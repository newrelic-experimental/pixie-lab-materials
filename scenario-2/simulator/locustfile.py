from locust import task, between
from realbrowserlocusts import HeadlessChromeLocust

class LocustUser(HeadlessChromeLocust):
    wait_time = between(15, 30)

    def on_stop(self):
        self.client.quit()

    @task
    def view_admin(self):
        self.client.get("http://frontend-service/admin?password=ilovecats")
