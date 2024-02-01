<h2>Introduction</h2>

Gitfinder is a flutter app, that will help developer to find repositories. This application can search repositories using the github api. By using gitfinder, you can search repositories as well as you can see the details of the repositories like repositories name, owner name, star etc. Also, you can sort the data by last updated date time or star count.

<h2>Dependencies Used</h2>
<ul style="list-style-type:circle;">
  <li>Provider</li>
  <li>http</li>
  <li>url_launcher</li>
  <li>Isar</li>
  <li>path_provider</li>
</ul>

<h2>API</h2>
This app uses github api. Which is free for everyone. This api can handle 6000 call per hour. This app also can handle errors from api.
Api_key: https://api.github.com/search/repositories?q=name:flutter&per_page=10

<h2>Statemangement</h2>
Statemanagement is one of the main features of the gitfinder. To develop this app, i used provider statemanagement architehture. Which is one of the most used statemanager in flutter.

<h2>Working Process</h2>
At the starting of the application, gitfinder takes a keyword from the user. Then, by clicking on search button.
This will app find the repositories related to that keyword. Then by simply going down user can get more repositories.
If user wants to see the details related to a repository, they have to simply click on that listtile. It will show related data about the repository.
This app also can sort data by user preference, like if they wanted to see. Which repository was last updated. It will sort all that data for user.
It also can sort data by starcount.

<h2>User Interface</h2>
<br>
<div align="center">
<img src="https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/9c43782b-3377-41af-a745-3dbb5e592b5c" width="250">
</div>
<div align="center">
<img src="https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/b5ee2a86-b324-432d-9feb-149e35205fdb" width="250">
</div>
<div align="center">
<img src="https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/5e6731fe-88d5-45c2-9376-0d29ba6304f2" width="250">
</div>
<div align="center">
<img src="https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/26194ae0-42dc-434f-b85c-e65b49fedb6d" width="250">
</div>
<div align="center">
<img src="https://github.com/RayhanMahmud256/Starcoder-24-flutter-/assets/99743908/23b0bddd-2614-4576-89d2-57bf012fc90d" width="250">
</div>

<h2>Testing and Results</h2>
After testing the app, we find out this app can handle the api data easily with consistancy. Also, easily handle the state of datas.

<h2>Future Work</h2>
In the future, we can use api to show the users profile along side the repositories.

