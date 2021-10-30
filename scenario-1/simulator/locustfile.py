import random
import time
import logging
from locust import task, between
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select
from realbrowserlocusts import HeadlessChromeLocust

class LocustUser(HeadlessChromeLocust):
    wait_time = between(30, 45)

    def on_stop(self):
        self.client.quit()

    def choose_hat_type(self):
        hat_select = Select(self.client.find_element(By.ID, "typeInput"))
        hat_select.select_by_value("PIXIE")

    def hat_me(self):
        hat_me_button = self.client.find_element(By.CSS_SELECTOR, ".btn.btn-primary.m-2")
        hat_me_button.click()

    @task
    def submit_hat(self):
        self.client.get("http://frontend-service")
        time.sleep(5)
        self.choose_hat_type()
        self.hat_me()
