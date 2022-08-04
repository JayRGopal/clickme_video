# TODO: Convert into a yaml and use pyyaml insead of class/function-based configs
import os


class Map(dict):
    """
    Example:
    m = Map({'first_name': 'Eduardo'}, last_name='Pool', age=24, sports=['Soccer'])
    """
    def __init__(self, *args, **kwargs):
        super(Map, self).__init__(*args, **kwargs)
        for arg in args:
            if isinstance(arg, dict):
                for k, v in arg.iteritems():
                    self[k] = v

        if kwargs:
            for k, v in kwargs.iteritems():
                self[k] = v

    def __getattr__(self, attr):
        return self.get(attr)

    def __setattr__(self, key, value):
        self.__setitem__(key, value)

    def __setitem__(self, key, value):
        super(Map, self).__setitem__(key, value)
        self.__dict__.update({key: value})

    def __delattr__(self, item):
        self.__delitem__(item)

    def __delitem__(self, key):
        super(Map, self).__delitem__(key)
        del self.__dict__[key]

def project_settings():
    node_name = os.uname()[1]  # If you want a machine-conditional path use this

    model_path = "/path/to/model_weigths"
    imagenet_train_path = "/path/to/tserre_images"
    # imagenet_train_path = '/media/data_cifs/clicktionary/webapp_data/lmdb_trains/'
    imagenet_validation_path = '/media/data_cifs/clicktionary/webapp_data/lmdb_validations/'
    # video_path
    # winoground_path
    training_map_path = "database_click_images"
    training_image_path = "images"
    click_map_predictions = "model_click_predictions"
    im_ext = '.JPEG'
    click_box_radius = 9
    train_iters = 10000
    val_iters = 100
    nb_epoch = 1


    d = {
        #Images for the click map prediction and folders for saving the predictions
        'training_map_path' : training_map_path,
        'click_map_predictions' : click_map_predictions,
        'validation_image_path' : imagenet_validation_path,
        'training_image_path' : training_image_path,
        'im_ext' : im_ex,
        'imagenet_train_path' : imagenet_train_path, #Now combine a subset of these, with a subset of validation_image_path, and the below 10 images
        'mirc_image_path' : mirc_image_path,
        'nsf_image_path' : nsf_image_path,

        #Images for the click map prediction and folders for saving the predictions
        'click_box_radius' : click_box_radius,

        #For finetuning
        'train_iters' : train_iters, #not implemented yet
        'val_iters' : val_iters, #not implemented yet
        'nb_epoch' : nb_epoch,

        #For finetuning the click predictor
        'model_path' : model_path,
        'model_init_training_weights' : os.path.join(model_path, 'models'),
        'model_checkpoints' : os.path.join(model_path, 'model_checkpoints'),

        #Paths for testing CNNs with attention maps
        'tf_path' : tf_path,
        'cnn_path' : os.path.join(tf_path, 'experiments/MIRC_webapp/'),
        'cnn_model_path' : os.path.join(tf_path, 'pretrained_weights/'),
        'cnn_architecture_path' : os.path.join(tf_path, 'model_depo/'),
        'part_syn_file_path' : os.path.join(tf_path, 'data/ilsvrc_2012/synset_names.txt'),
        'full_syn_file_path' : os.path.join(tf_path, 'data/ilsvrc_2012/synset.txt'),
        'cnn_models' : ['vgg16']
        'cnn_types' : ['baseline', 'attention']
    }
    d = Map(d)

    #Make this directory if it doesn't exist yet
    if not os.path.exists(d.training_map_path):
        os.makedirs(d.training_map_path)

    return d

