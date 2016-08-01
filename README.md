# Pre-work - *tippy*

**tippy** is a tip calculator application for iOS.

Submitted by: **Mike Tehranian**

Time spent: **9** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [x] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [x] Validate the bill input field and present a "shake" animation if there are more than one decimal point or letters.
- [x] Added a light or dark background theme chooser in the Settings view.
- [x] Added a color theme chooser for the text and UI components in the Settings view.
- [x] Added an app icon for the home screen.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/iXi3bqd.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

The biggest debugging challenge that I had was figuring out where to place the code that would save the bill and its date for later retrieval. I originally put the code to save the old bill and date in ```viewWillDisappear()```, but after debugging I realized this method was not being called when the app was closed. So I moved the code that saves the last bill and its date to the calculation step to make sure it was always captured.
I spent about an hour learning how to implement the dark theme and the various colors themes. I found a lot of examples online on modifying the style of UI components and they were very helpful.
I found the example of the shake animation on StackOverflow and I thought it would be a nice UX to add.
Finally, I spent more time than I originally planned on setting the home screen application icon. I could not find a free icon with the required size contraints so I paid for a nice icon from icons8.com and used that for my application. It was not a difficult task but just something that took me longer than I anticipated.
I really like the Swift language and I was able to pick it up really fast and its already becoming one of my favorite languages to use! I am pleased that I have not been bitten by esoteric language "gotchas" and the language follows the principle of least astonishment (POLA).

## License

    Copyright [2016] [Mike Tehranian]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

