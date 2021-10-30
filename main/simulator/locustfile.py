import random
from locust import task, between
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select
from realbrowserlocusts import HeadlessChromeLocust

class LocustUser(HeadlessChromeLocust):
    timeout = 10
    wait_time = between(30, 45)

    def on_stop(self):
        self.client.quit()

    def hat_me(self):
        hat_me_button = self.client.find_element(By.CSS_SELECTOR, ".btn.btn-primary.m-2")
        hat_me_button.click()

    @task(2)
    def submit_hat(self):
        self.client.get("http://frontend-service")
        self.hat_me()

    @task(1)
    def view_admin(self):
        self.client.get("http://frontend-service/admin?password=ilovecats")
