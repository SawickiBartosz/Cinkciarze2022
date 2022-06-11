import sys
import pandas as pd
import datetime
import os
import requests
import time


def get_rates(start_date, end_date, API_URL):
    r = requests.get(API_URL.format(table='A', startDate=start_date, endDate=end_date))
    if r.status_code == 200:
        currencies = [cur['code'] for cur in r.json()[0]['rates']]
        dates = [record['effectiveDate'] for record in r.json()]
        return pd.DataFrame({cur:[
            list(filter(None,[rate['mid'] if rate['code'] == cur else None for rate in record['rates']])) 
            for record in r.json()] for cur in currencies}, index=dates).applymap(lambda x: x[0] if len(x)>0 else None)
    raise ConnectionError("API call status != 200")


def add90days(date: datetime.date):
    delta = datetime.timedelta(days = 90)
    return date + delta


def fill_blank_days(df: pd.DataFrame):
    df['date'] = df.apply(
        lambda x: datetime.date.fromisoformat(x['index']), axis=1)
    all_dates = pd.date_range(min(df['date']), max(df['date']))
    codes = df['code'].unique()
    for date in all_dates:
        date = date.to_pydatetime().date()

        if len(df[df['index'] == date.isoformat()]) == 0:
            prev_date = date - datetime.timedelta(days=1)
            new_day_df = pd.DataFrame({'index':[], 'code':[], 'rate': []})
            for currency in codes:
                new_day_df = pd.concat([new_day_df, 
                    pd.DataFrame({'index':[date.isoformat()], 
                                    'code':[currency], 
                                    'rate': list(df[(df['index'] == prev_date.isoformat()) & (df['code'] == currency)]['rate'])})])
            df = pd.concat([df, new_day_df])
    df = df.sort_values('index')
    return df.drop('date', axis=1)


def main():
    args = sys.argv[1:]
    if len(args) == 2:
        end_date = min(datetime.date.fromisoformat(args[1]), datetime.date.today() - datetime.timedelta(days=1))
        start_date = datetime.date.fromisoformat(args[0])

    elif len(args) == 0:
        end_date = datetime.date.today() - datetime.timedelta(days=1)
        month, year = (end_date.month-1, end_date.year) if end_date.month != 1 else (12, end_date.year-1)
        start_date = end_date.replace(year, month)

    elif len(args) == 1:
        end_date = datetime.date.today() - datetime.timedelta(days=1)
        start_date = datetime.date.fromisoformat(args[0])

    API_URL = "http://api.nbp.pl/api/exchangerates/tables/{table}/{startDate}/{endDate}/?format=json"
    split_date = start_date
    rates = pd.DataFrame({'index':[], 'code':[], 'rate':[]})
    while split_date < end_date:
        begin = split_date
        end = min(add90days(split_date), end_date)
        split_date = end
        curr_rates = get_rates(begin.isoformat(), end.isoformat(), API_URL)
        curr_rates = curr_rates.reset_index().melt(id_vars='index', value_name='rate', var_name='code')
        rates = pd.concat([rates, curr_rates], axis=0)
        time.sleep(0.5)

    rates = fill_blank_days(rates)
    file_path = os.path.join('TEMP', 'rates.csv')
    rates.to_csv(file_path, mode='w+', index=False)


if __name__ == '__main__':
    main()
    