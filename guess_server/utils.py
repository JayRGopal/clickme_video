#!/usr/bin/env python
# Utility functions for CNN server
import tensorflow as tf
import os
from datetime import timedelta
from flask import make_response, request, current_app
from functools import update_wrapper
import numpy as np
import skimage.io
from PIL import Image

# Image loader that keeps resizes+crops image and keeps last n images cached in memory
class ImageCache:
    def __init__(self, data_path, max_cache_size=10, input_size=(256, 256, 3), crop_size=(224, 224)):
        self.data_path = data_path
        self.cached_images = {}
        self.cached_last_accessed = {}
        self.access_counter = 0
        self.max_cache_size = max_cache_size
        self.input_size = tuple(input_size)
        self.crop_size = crop_size
        self.crop_margin = [(i - c) / 2 for (i, c) in zip(self.input_size[:2], self.crop_size)]

    def load_image(self, filename):
        # Load image in TF format
        #import pdb;pdb.set_trace()
        full_filename = os.path.join(self.data_path, filename)
        image = skimage.io.imread(full_filename) / 255.0

        #final_size=(224,224)
        #_mean_imagenet = tf.constant([0.485, 0.456, 0.406], shape=[1, 1, 3], dtype=tf.float32)
        #_std_imagenet =  tf.constant([0.229, 0.224, 0.225], shape=[1, 1, 3], dtype=tf.float32)
        #image  = tf.convert_to_tensor(image / 255.0, dtype=tf.float32)
        #image  = tf.convert_to_tensor(image - _mean_imagenet, dtype=tf.float32)
        #image  = tf.convert_to_tensor(image / _std_imagenet, dtype=tf.float32)
        #image = image[None]
        #image = tf.image.resize_with_crop_or_pad(image, final_size[0], final_size[1])
        #image   = np.array(image)

        # Grayscale to RGB
       # if len(image.shape) == 2: image = np.dstack((image,) * 3)
       # if image.shape != self.input_size:
            # Resize to fit model
       #     print('  Reshaping image %s from %s to %s.' % (filename, str(image.shape), str(self.input_size)))
       #     image = image.resize(self.input_size)
        # Crop
        #import pdb;pdb.set_trace()
        #image = np.resize(image, (224,224,3))
        image = image[int(self.crop_margin[0]):int(self.crop_margin[0]+self.crop_size[0]), int(self.crop_margin[1]):int(self.crop_margin[1]+self.crop_size[1]),:]
        return image

    def get_image(self, filename):
        # Check cache
        image = self.cached_images.get(filename)
        if image is None:
            # Not in cache: Load image
            if len(self.cached_images) == self.max_cache_size:
                # Cache full. Remove oldest from cache before loading next image.
                oldest_filename = min(self.cached_last_accessed, key=self.cached_last_accessed.get)
                del self.cached_images[oldest_filename]
                del self.cached_last_accessed[oldest_filename]
                print('  Discarded cached image %s.' % (oldest_filename))
            image = self.load_image(filename)
            print('  Load new cache image  %s.' % (filename))
            self.cached_images[filename] = image
        # Remember cache age
        self.cached_images[filename] = self.access_counter
        return image
