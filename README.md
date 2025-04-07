# FastAPI Project Documentation

This project is a FastAPI application that provides an API for managing routines. 

## Project Structure

```
backend
├── routes
│   └── rotina_routes.py  # Defines the FastAPI router with a GET endpoint for routines
├── .gitignore             # Specifies files and directories to be ignored by Git
└── README.md              # Documentation for the project
```

## Installation

1. Clone the repository:
   ```
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```
   cd backend
   ```
3. Create a virtual environment:
   ```
   python -m venv venv
   ```
4. Activate the virtual environment:
   - On Windows:
     ```
     venv\Scripts\activate
     ```
   - On macOS/Linux:
     ```
     source venv/bin/activate
     ```
5. Install the required packages:
   ```
   pip install fastapi uvicorn
   ```

## Running the Application

To run the FastAPI application, use the following command:
```
uvicorn main:app --reload
```

Replace `main:app` with the appropriate module and application instance if necessary.

## API Endpoints

### List Routines

- **GET** `/rotina/`
  - Returns a list of routines.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes. 

## License

This project is licensed under the MIT License. See the LICENSE file for details.