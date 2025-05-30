from google.cloud import storage
from google.cloud.storage import transfer_manager
import json


class UploadGCloud:
    def __init__(self):
        self.client = storage.Client(project="asteroid-db-456716")
    def upload_nolocal(self,bucket_name, data, destination_blob_name):

        bucket = self.client.bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)
    
        # Optional: set a generation-match precondition to avoid potential race conditions
        # and data corruptions. The request to upload is aborted if the object's
        # generation number does not match your precondition. For a destination
        # object that does not yet exist, set the if_generation_match precondition to 0.
        # If the destination object already exists in your bucket, set instead a
        # generation-match precondition using its generation number.

        ndjson_lines = "\n".join([json.dumps(record, ensure_ascii=False) for record in data])

        # Upload to GCS
        blob.upload_from_string(ndjson_lines)
        
        print(
            f"File {data} uploaded to {destination_blob_name}."
        )

    def upload_blob(self, bucket_name, source_file_name, destination_blob_name):
        """Uploads a file to the bucket."""
        # The ID of your GCS bucket
        # The path to your file to upload
        # source_file_name = "local/path/to/file"
        # The ID of your GCS object
        # destination_blob_name = "storage-object-name"
        
        bucket = self.client.bucket(bucket_name)
        blob = bucket.blob(destination_blob_name)
    
        # Optional: set a generation-match precondition to avoid potential race conditions
        # and data corruptions. The request to upload is aborted if the object's
        # generation number does not match your precondition. For a destination
        # object that does not yet exist, set the if_generation_match precondition to 0.
        # If the destination object already exists in your bucket, set instead a
        # generation-match precondition using its generation number.
        generation_match_precondition = 0
    
        blob.upload_from_filename(source_file_name, if_generation_match=generation_match_precondition)
    
        print(
            f"File {source_file_name} uploaded to {destination_blob_name}."
        )