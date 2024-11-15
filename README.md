
# MCQ Marking Software

### Overview
The **MCQ Marking Software** is a MATLAB-based application designed to automate the marking of multiple-choice question (MCQ) answer sheets. It uses image processing techniques to compare a scanned marking scheme with student answer sheets, calculating scores automatically. The application provides a graphical user interface (GUI) for ease of use.

### Features
- **Marking Scheme Loading:** Load the MCQ marking scheme as an image.
- **Student Test Loading:** Load the student’s answer sheet for evaluation.
- **Automatic Scoring:** Compare the marking scheme with the student's answers and compute the score.
- **Save Results:** Export results as a text file.
- **Interactive GUI:** User-friendly interface for loading files, displaying results, and managing operations.

### Requirements
- MATLAB R2016a or later
- Image Processing Toolbox
- Compatible operating system for running MATLAB

### Installation
1. Clone or download this repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/mcq-marking-software.git
   ```
2. Open MATLAB and navigate to the folder containing the downloaded files.
3. Open the `test4real.fig` and `test4real.m` files in MATLAB.

### Usage
1. **Launch the GUI:**
   - Run the `test4real.m` file from the MATLAB command window.
   
2. **Load Marking Scheme:**
   - Click the "Load Scheme" button and select the image file containing the marking scheme.

3. **Load Student Test:**
   - Click the "Load Student" button and select the student’s test image.

4. **Mark Answers:**
   - Click the "Mark" button to evaluate the student’s answers against the marking scheme.

5. **View and Save Results:**
   - The score and evaluation details will be displayed on the GUI. Save the results as a text file by clicking "Save as Text."

6. **Reset or Exit:**
   - Use the "Reset" button to clear all fields or "Exit" to close the application.

### File Descriptions
- `test4real.m`: Main MATLAB script implementing the GUI and core functionality.
- `test4real.fig`: GUI design file created using MATLAB GUIDE.
- **Global Variables:**
  - `x`, `y`: Images for the marking scheme and student test.
  - `Str1`, `Str2`, `str3`: Text strings for results display.
  - `num`, `num1`: Variables holding the number of detected elements in each image.

### License
This project is licensed under the MIT License. See the LICENSE file for more details.

### Acknowledgments
Developed by **Emmanuel Asante** (BSc Mathematics, UMaT).  
Version 1.0, created on April 11, 2016.
