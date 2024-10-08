# Lyrics_AI
# AI-Assisted Music Production Web App

This project is an AI-powered web application that assists in generating and refining song lyrics based on user input. It is built using **Flutter** for the frontend and **Flask** for the backend. The AI model is powered by Google Generative AI, which generates song lyrics based on the given prompts.

## Deployment
- The app is currently deployed on Vercel:
 [Link](https://lyricsai.vercel.app/)

<div align="center">
<image src="./image.jpg">
</div>
 
## Features

- **Custom Input for Language and Genre**: Users can specify the language and genre of the song.
- **Song Description Input**: Users can describe the song they want, and the app generates relevant lyrics.
- **Lyrics Generation**: The app connects to a REST API that utilizes Google Generative AI to generate song lyrics based on the provided inputs.
- **Lyrics Refinement**: Users can refine previously generated lyrics by modifying them according to the genre and song description.
- **Dynamic Background Color**: The background color of the app changes dynamically based on the selected genre.
- **Responsive UI**: The UI is responsive and scrollable, ensuring a smooth user experience even with large inputs.

## Technology Stack

### Frontend
- **Flutter**: Handles the user interface, including input fields for language, genre, and song description, as well as buttons for generating and refining lyrics.
- **HTTP Requests**: The app sends POST requests to the backend API to generate and refine lyrics.

### Backend
- **Flask**: A lightweight Python framework for building the API.
- **Google Generative AI**: A powerful AI model that generates the lyrics based on the user's prompt.
- **CORS**: Cross-Origin Resource Sharing is enabled to allow communication between the frontend and backend.

## Setup Instructions

### Frontend (Flutter App)

1. **Install Flutter**: Make sure you have Flutter installed. You can find instructions [here](https://flutter.dev/docs/get-started/install).
   
2. **Clone the Repository**:
   ```bash
   git clone https://github.com/rohakbora/Lyrics-AI.git
3. **Navigate to the Project Directory:**
   ```bash
    cd Lyrics-AI
4. **Install Dependencies:**
    ```bash
    flutter pub get
5. **Run the App:**
    ```bash
    flutter run
## Backend RESTful API
1. **API**: Access the code [here](https://github.com/rohakbora/Lyrics_AI_API/blob/main/app.py).
2. **Install Python**: Make sure you have Python installed.
3. **Install Dependencies:**
    ```bash
    pip install -r requirements.txt
4. **Set Up Environment Variables**:
   - Create a .env file in the project root.
   - Get Google API key [here](https://ai.google.dev/gemini-api).
   - Add your Google API key in the .env file
     ```bash
     GOOGLE_API_KEY=your-google-api-key
5. **Run the Flask Server**:
    ```bash
   python app.py

## Future Enhancements
- Add more customization options for refining lyrics.
- Allow users to save generated lyrics.
- Improve error handling and user feedback.
