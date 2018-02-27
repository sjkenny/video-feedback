# video-feedback
### Video feedback simulation sandbox
Video feedback is a phenomenon in which the Nth frame of a video is dependent on previous frames.  Such a system is a closed feedback loop, a physical example of which is a camera aimed at its own output projected on a screen.  These setups can create interesting visual patterns and effects, and can even exhibit characteristics of chaos.  One example can be seen [here](https://www.youtube.com/watch?v=B4Kn3djJMCE).  
#### video_feedback.m
A closed-loop video feedback system can be easily simulated by applying some transformation to an input image, and then re-introducing it as the input.  Exploration of the transformation parameter space can reveal interesting spatiotemporal patterns.  In this script, manually adjust any of the parameters and run.  The output video can be saved instead of rendering in real-time to speed up the simulation.  Several examples with various parameters and a periodic perturbation can be seen in [this video](https://www.youtube.com/watch?v=q7OoUg5FhjM).

