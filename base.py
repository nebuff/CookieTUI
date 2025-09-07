from textual.app import App, ComposeResult
from textual.containers import Container
from textual.widgets import Button, Static
from textual.reactive import reactive
from textual.timer import Timer

class CookieClickerApp(App):
    CSS = """
    Screen {
        align: center middle;
    }
    #cookie {
        border: round green;
        padding: 2;
        width: 20;
        content-align: center middle;
    }
    #stats {
        padding: 1;
        height: 5;
        content-align: center middle;
    }
    Button {
        margin: 1;
    }
    """

    cookies = reactive(0)
    cps = reactive(0)  # cookies per second

    def compose(self) -> ComposeResult:
        yield Static("🍪 Click the cookie!", id="cookie")
        yield Static(f"Cookies: {self.cookies}\nCPS: {self.cps}", id="stats")
        yield Container(
            Button("Click Cookie 🍪", id="click_cookie"),
            Button("Buy Auto Clicker (10 cookies)", id="buy_autoclicker")
        )

    def on_mount(self):
        # Auto CPS timer
        self.set_interval(1, self.add_cookies_per_second)

    def add_cookies_per_second(self):
        if self.cps > 0:
            self.cookies += self.cps
            self.update_stats()

    def update_stats(self):
        stats = self.query_one("#stats", Static)
        stats.update(f"Cookies: {self.cookies}\nCPS: {self.cps}")

    def on_button_pressed(self, event: Button.Pressed):
        if event.button.id == "click_cookie":
            self.cookies += 1
            self.update_stats()
        elif event.button.id == "buy_autoclicker":
            if self.cookies >= 10:
                self.cookies -= 10
                self.cps += 1
                self.update_stats()

if __name__ == "__main__":
    CookieClickerApp().run()
