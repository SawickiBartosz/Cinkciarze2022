import pandas as pd

import unittest
from historic_rates import get_rates, main
from unittest.mock import patch


class Test(unittest.TestCase):
    API_URL = "http://api.nbp.pl/api/exchangerates/tables/{table}/{startDate}/{endDate}/?format=json"

    def test_basic(self):
        self.assertIsInstance(get_rates('2022-01-30', '2022-03-28', self.API_URL), pd.DataFrame)

    def test_exception(self):
        with self.assertRaises(ConnectionError):
            rates = get_rates('2021-01-01', '2022-01-01', self.API_URL)

    def test_main(self):
        results_path = 'TEMP/rates.csv'
        main()
        with open(results_path, 'r') as f:
            header = f.readline()
            self.assertTrue(header, 'index,code,rate')


    def test_main2(self):
        results_path = 'TEMP/rates.csv'
        with patch("sys.argv", ["historic_rates.py", "2021-01-01", "2021-01-31"]):
            main()
            with open(results_path, 'r') as f:
                row = f.readlines()[1]
                self.assertEqual(row.split(",")[0], "2021-01-04")

                
if __name__ == '__main__':
    unittest.main()