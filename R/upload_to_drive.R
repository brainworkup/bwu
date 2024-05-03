#' Upload a file to Google Drive
#'
#' This function uploads a specified file to Google Drive under a specified file name.
#' It requires the googledrive package and proper authentication to access Google Drive.
#'
#' @param file_path The local path of the file to be uploaded.
#' @param file_name The name to assign to the file once uploaded on Google Drive.
#'
#' @return The function returns an object of class `drive_file` which contains
#' metadata of the uploaded file.
#' @export
#'
#' @examples
#' # Make sure to replace '/path/to/your/file.csv' and 'file_name.csv'
#' # with actual values. Uncomment and run:
#' # upload_to_drive("/path/to/your/file.csv", "file_name.csv")
#'
#' @importFrom googledrive drive_upload drive_scopes
#' @keywords cloud storage
upload_to_drive <- function(file_path, file_name) {
  # Set the scope to allow viewing and managing files in Google Drive
  drive_scopes(scopes = "https://www.googleapis.com/auth/drive.file")

  # Authenticate and create a drive (commented out for safety, ensure this is configured)
  # drive_auth()

  # Upload a file to the drive
  drive_upload(media = file_path, name = file_name)
}
