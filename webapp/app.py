import random
import time
import uuid

from flask import Flask

app = Flask(__name__)

print("Starting app")

response_codes = [200] * 85
response_codes += [401] * 10
response_codes += [404] * 3
response_codes += [403] * 2
response_codes += [500] * 1

sleep_times = [0.1] * 30
sleep_times += [0.5] * 20
sleep_times += [1] * 15
sleep_times += [5] * 15
sleep_times += [10] * 10
sleep_times += [30] * 3
sleep_times += [40] * 3
sleep_times += [60] * 2
sleep_times += [90] * 1
sleep_times += [120] * 1


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
    app.run(threaded=True)
