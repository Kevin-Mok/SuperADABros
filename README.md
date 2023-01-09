# Demo
### [Demo Video](https://youtu.be/vRdENLGrBqM)
![Demo Image](https://user-images.githubusercontent.com/25857736/211397451-8d427837-1ca8-4a95-b27e-6d29ca603a2c.png)

# Inspiration
I was browsing the web looking for existing assistive technology to get
inspiration. I came across the [r/disability
subreddit](https://www.reddit.com/r/disability) and found [this GIF of a
video](https://www.reddit.com/r/disability/comments/7v9ztc/super_ada_compliant_mario/)
as one of the top upvoted posts of all time. As a gamer myself, I thought
this would a great and fun idea to try and implement as an actual game.

While I had the theme of accessibility at that point, it didn't actually
have any accessibility features. My friend suggested the idea of using eye
tracking from [OpenCV](https://opencv.org/). I looked into it and
ultimately decided on using head tracking for more stability and control.

# What It Does
It is essentially a clone of the original Super Mario Bros, but with the
twist that he can't jump. So, there are ramps and lifts to make up for it.
There are also a variety of input methods to suit whatever method is most
comfortable for the user:
- head movement
  - using [this script](https://github.com/Kevin-Mok/face-tracker)
- mouse
- keyboard
- controller

A demo version that can be played with the mouse on multiple platforms (Windows, OS X, Linux and web) can be found [on the releases page](https://github.com/Kevin-Mok/super-ada-bros/releases). Take note of the fact that there may be existing bugs in the release due to time constraint. There is also a built-in checkpoint system that moves you on to next the checkpoint (pipe) after 3 deaths, so you can see the whole level without any frustration.

### How I Built It
OpenCV and Godot.

### Challenges I Ran Into
Game physics is more complex than I thought it would be, even with it being
a simple 2D platformer.

### Accomplishments That I'm Proud Of
Making my first game. I'm pretty happy with the way it turned out given the
amount of time I had.

### What I Learned
Basic game development skills and a bit of visual computing for the face
tracking and game physics.

### What's Next For Super ADA Bros
- adjustable settings to match user's exact preferences
- more features from original game
  - more mechanics with movement and enemies

### Dev Log
You can find some update pictures I posted while making this at the
[Devpost for this project](https://devpost.com/software/super-ada-bros).
