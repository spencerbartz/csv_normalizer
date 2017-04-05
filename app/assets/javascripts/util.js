function toggleUploadButton() {
  if(document.getElementById('csvfile').value === "") {
    document.getElementById("upload-button").style.display = 'none';
  }
  else {
    document.getElementById("upload-button").style.display = 'block';
  }
}
