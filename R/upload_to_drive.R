library(googledrive)

# Define a function to upload a file to Google Drive
upload_to_drive <- function(file_path, file_name) {
  # Set the scope to allow viewing and managing files in Google Drive
  drive_scopes(scopes = "https://www.googleapis.com/auth/drive.file")

  # Authenticate and create a drive (commented out for safety, ensure this is configured)
  # drive_auth()

  # Upload a file to the drive
  drive_upload(media = file_path, name = file_name)
}

# Example usage of the function
# Make sure you replace '/path/to/your/file.csv' and 'file_name.csv' with actual values
# upload_to_drive("/path/to/your/file.csv", "file_name.csv")
