# Whalepass Godot API Request Example

![GitHub Created At](https://img.shields.io/github/created-at/whalepass/godot)
[![Made with Godot](https://img.shields.io/badge/Made%20with-Godot-478CBF?style=flat&logo=godot%20engine&logoColor=white)](https://godotengine.org)

## :book: About  

This is a sample project showcasing how to integrate and use the [Whalepass API](https://www.whalepass.gg/documentation/auth) with the **Godot Engine**.  

The goal is to provide a functional and well-documented foundation for developers who want to explore using the Whalepass API, whether for authentication, user management, or other related features.  

In this project, you will find:  
- Initial setup for the Whalepass API in Godot.  
- Examples of API calls.  
- A basic structure to expand and customize as needed.  

### ⚠️This project was built using **Godot 3.x**
If you plan to use **Godot 4.x**, note that the project may require manual adjustments during import. This is due to changes in the WebSocket implementation in Godot 4.x, which may lead to compatibility issues.

Make sure to review and adapt the WebSocket-related code to ensure proper functionality in Godot 4.x.

![image](https://github.com/user-attachments/assets/10ae07fc-d58a-4f3d-8ed7-c27e56b698b6)

## Functionalities Contained in the Project Example

- `Complete Player Challenge`
- `Get Player Progress`
- `Get Battlepass Info`
- `Increment Experience (HARD)`
- `Increment Experience (SOFT)`
- `Redirect Player to Dashboard`

## WhalepassAPI Node Configuration

![image](https://github.com/user-attachments/assets/93e5427b-5263-4bf7-b5a3-13f8b1883bfd)

This project leverages **Godot's `export var`** feature to simplify the integration process. You can directly assign values like **Battlepass ID**, **API Key**, and **Game ID** to the relevant nodes in the editor, without modifying the code.  

This approach ensures a more streamlined setup and makes it easier to configure and test the Whalepass API in your project.

