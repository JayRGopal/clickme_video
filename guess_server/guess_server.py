#!/usr/bin/env python
# CNN server that returns model guesses on a partially revealed image

import os, sys
from flask import Flask, request, Response
import numpy as np
import json
from guesser import load_guesser, get_image_prediction
import traceback

# Init CNN
oracle = load_guesser()

# Init Flask
app = Flask(__name__)
#app.debug = True

# Setup query route
@app.route('/guess', methods=['GET', 'POST', 'OPTIONS'])
def guess_path(): # #
    # Get request data
   # import pdb;pdb.set_trace()
    rdata = json.loads(list(request.form.keys())[0])
    print('Clicks on %s: %d' % (rdata['image_name'], len(rdata['click_array'])))
    # Get true label
    class_index = int(os.path.basename(rdata['image_name']).split('_')[0])
    print('True label: %s' % oracle.class_names[class_index])
    # Ask the oracle
    try:
        #import pdb;pdb.set_trace()
        img_name_debug = rdata['image_name'].split('/')[1]
        #global prediction
        prediction = get_image_prediction(oracle, img_name_debug, rdata['click_array']) # rdata['image_name'], rdata['click_array'])
        #import pdb;pdb.set_trace()
    except:
        print("Exception in user code:")
        print('-'*60)
        traceback.print_exc(file=sys.stdout)
        print('-'*60)
    print('...guess: {}'.format(prediction))#% prediction)
    # Allow cross origin
    resp = Response(prediction)
    h = resp.headers
    h['Access-Control-Allow-Origin'] = '*'
    h['Access-Control-Allow-Methods'] = ['GET', 'POST', 'OPTIONS']
    h['Access-Control-Max-Age'] = '21600'
    return resp

# Start flask app
app.run(host='0.0.0.0', port=7777, debug=True)
