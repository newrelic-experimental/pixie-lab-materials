import random
from locust import task, between
from selenium.webdriver.common.by import By
from selenium.webdriver.support.select import Select
from realbrowserlocusts import HeadlessChromeLocust

class LocustUser(HeadlessChromeLocust):
    timeout = 10
    wait_time = between(30, 60)

    def on_stop(self):
        self.client.quit()

    def choose_num_hats(self):
        num_hats = random.randint(1, 5)

        num_hats_input = self.client.find_element(By.ID, "numberHats")
        num_hats_input.clear()
        num_hats_input.send_keys(num_hats)

    def choose_hat_type(self):
        hat_select = Select(self.client.find_element(By.ID, "typeInput"))

        hat_types = hat_select.options[1:]
        weights = [20 if hat_type.text == "PIXIE" else 1 for hat_type in hat_types]
        random_choice = random.choices(population=hat_types, weights=weights, k=1)[0]
        hat_select.select_by_value(random_choice.text)

    def hat_me(self):
        hat_me_button = self.client.find_element(By.CSS_SELECTOR, ".btn.btn-primary.m-2")
        hat_me_button.click()

    @task(3)
    def submit_hat(self):
        self.client.get("http://frontend-service")
        self.choose_num_hats()
        self.choose_hat_type()
        self.hat_me()

    @task(1)
    def view_admin(self):
        self.client.get("http://frontend-service/admin?password=ilovecats")
