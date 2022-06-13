import pandas as pd

from unittest import TestCase
from historic_rates import get_rates


class Test(TestCase):
    API_URL = "http://api.nbp.pl/api/exchangerates/tables/{table}/{startDate}/{endDate}/?format=json"

    def test_basic(self):
        self.assertIsInstance(get_rates('2022-01-30', '2022-03-28', self.API_URL), pd.DataFrame)

    def test_exception(self):
        with self.assertRaises(ConnectionError):
            rates = get_rates('2021-01-01', '2022-01-01', self.API_URL)
