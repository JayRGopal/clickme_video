import cv2
import matplotlib.pyplot as plt

def extract_frame(vid_path, frame_number):
  cap = cv2.VideoCapture(vid_path)
  cap.set(cv2.CAP_PROP_POS_FRAMES, frame_number-1)
  res, frame = cap.read()
  return frame
