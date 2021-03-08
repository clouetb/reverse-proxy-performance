import random
import time
import uuid

from flask import Flask

app = Flask(__name__)

print("Starting app")
response_codes = [200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 200, 400, 401, 403, 404, 404, 404, 404, 500]
sleep_times = [0.1, 0.1, 0.1, 0.1, 0.2, 0.2, 0.5, 0.5, 0.5, 0.5, 1, 1, 1, 2, 2, 2, 5, 5, 10, 10, 20,
               40, 60, 90, 120]


@app.route('/<request>')
def prepare_response(request):
    chosen_response_code = random.choice(response_codes)
    chosen_sleep_time = random.choice(sleep_times)
    response_id = uuid.uuid4()
    print(f"Request is {request}, "
        f"response code is {chosen_response_code},"
        f" will wait {chosen_sleep_time} before serving response, id is {response_id}")
    time.sleep(chosen_sleep_time)
    return f"{{\n    request:\"{request}\",\n    id:\"{response_id}\"\n    return_code:{chosen_response_code}\n}}",\
           chosen_response_code


if __name__ == '__main__':
    print("Starting app")
    app.run()
