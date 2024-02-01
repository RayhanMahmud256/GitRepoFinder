<h4>Introduction</h4>
Gitfinder is a flutter app, that will help developer to find repositories. This application can search repositories using the github api. By using gitfinder, you can search repositories as well as you can see the details of the repositories like repositories name, owner name, star etc. Also, you can sort the data by last updated date time or star count.
<h4>Dependencies</h4>
<ul>
  <li>Provider</li>
  <li>http</li>
  <li>url_launcher</li>
  <li>Isar</li>
  <li>path_provider</li>
</ul>
<h4>API</h4>
This app uses github api. Which is free for everyone. This api can handle 6000 call per hour. This app also can handle errors from api.
Api_key: https://api.github.com/search/repositories?q=name:flutter&per_page=10
<h4>Statemangement</h4>
Statemanagement is one of the main features of the gitfinder. To develop this app, i used provider statemanagement architehture. Which is one of the most used statemanager in flutter.
<h4>Working Process</h4>
At the starting of the application, gitfinder takes a keyword from the user. Then, by clicking on search button.<br>
![Screenshot_20240201_132748_com example gitapihandler](https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/9c43782b-3377-41af-a745-3dbb5e592b5c)

This app find the repositories related to that keyword. Then by simply going down user can get more repositories.<br>
![Screenshot_20240201_132758_com example gitapihandler](https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/92b924e4-4d8a-4026-a9a2-3db9d0d751ea)

If user wants to see the details related to a repository, they have to simply click on that listtile. It will show related data about the repository.<br>
![Screenshot_20240201_132808_com example gitapihandler](https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/0b284829-0ae0-48b6-9440-641c421e3f20)

