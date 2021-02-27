#right now only a simple hull to be able to use sockets to communicate with a server


from flask import Flask, render_template
from flask_socketio import SocketIO
import json

app = Flask(__name__)
#app.config['SECRET_KEY'] = 'vnkdjnfjknfl1232#'
socketio = SocketIO(app)


list_datasets=["blubb","bla"]
@app.route('/')
def sessions():
    return render_template('session.html')

def messageReceived(methods=['GET', 'POST']):
    print('message was received!!!')

@socketio.on('my event')
def handle_my_custom_event(json_msg, methods=['GET', 'POST']):
    print('received my event: ' + str(json_msg))
    if "message" in json_msg:
        print(json_msg["message"])
        if json_msg["message"] in list_datasets:
            print("The word is in the list!")
        else:
            print("The word is not in the list!")
    socketio.emit('my response', json_msg, callback=messageReceived)

if __name__ == '__main__':
    socketio.run(app, debug=True)
