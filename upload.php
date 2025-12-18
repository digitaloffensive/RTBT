<?php
// Handle file upload when form is submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Directory where files will be saved
    $targetDir = __DIR__ . "/uploads/";

    // Create directory if it doesn't exist
    if (!is_dir($targetDir)) {
        mkdir($targetDir, 0755, true);
    }

    // Check if file was uploaded without errors
    if (isset($_FILES["file"]) && $_FILES["file"]["error"] === UPLOAD_ERR_OK) {
        $fileTmpPath = $_FILES["file"]["tmp_name"];
        $fileName = basename($_FILES["file"]["name"]);
        $fileSize = $_FILES["file"]["size"];
        $fileType = mime_content_type($fileTmpPath);

        // Allowed file types (adjust as needed)
        $allowedTypes = ["image/jpeg", "image/png", "application/pdf", "text/plain"];

        // Security checks
        if (!in_array($fileType, $allowedTypes)) {
            echo "<p style='color:red;'>Error: File type not allowed.</p>";
        } elseif ($fileSize > 5 * 1024 * 1024) { // 5 MB limit
            echo "<p style='color:red;'>Error: File is too large.</p>";
        } else {
            // Generate a safe unique filename
            $safeFileName = uniqid("upload_", true) . "_" . preg_replace("/[^a-zA-Z0-9\._-]/", "_", $fileName);
            $destPath = $targetDir . $safeFileName;

            if (move_uploaded_file($fileTmpPath, $destPath)) {
                echo "<p style='color:green;'>File uploaded successfully: uploads/" . htmlspecialchars($safeFileName) . "</p>";
            } else {
                echo "<p style='color:red;'>Error: Could not save file.</p>";
            }
        }
    } else {
        echo "<p style='color:red;'>Error: No file uploaded or upload error.</p>";
    }
}
?>

<!-- HTML Upload Form -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple PHP File Upload</title>
</head>
<body>
    <h2>Upload a File</h2>
    <form action="" method="post" enctype="multipart/form-data">
        <label>Select file:</label>
        <input type="file" name="file" required>
        <br><br>
        <button type="submit">Upload</button>
    </form>
</body>
</html>
