from azure.storage.blob import BlockBlobService
import os
import logging
import sys

policies = sys.argv[1]
storage_account = sys.argv[2]
container_name = sys.argv[3]
try:  
    os.environ["SAS_TOKEN"]
except KeyError: 
    print("Please set the environment variable SAS_TOKEN")
    sys.exit(1)

token = os.environ["SAS_TOKEN"]

blobservice = BlockBlobService(storage_account, sas_token=token)


class AzureStorageManagement:
    def __init__(self, container):
        self.container = container

    # TODO: change it to work on deltas only 
    # list and delete the blobs in the container
    def delete_blob(self):
        blob_list = blobservice.list_blobs(self.container)
        for blob in blob_list:
            try:
                logging.info("deleting blob: %s" % blob.name)
                blobservice.delete_blob(self.container, blob.name, snapshot=None)
            except:
                logging.error("unable to delete blob or does not exist")

    # upload new files
    def upload_policies(self, policies_dir):
        for r, d, f in os.walk(policies_dir):
            try:
                for file in f:
                    if file.endswith(".yml"):       
                        try:
                            logging.info("uploading file: %s" % file)
                            blobservice.create_blob_from_path(self.container, file, (os.path.join(r, file)))
                        except:
                            logging.error("unable to upload: %s" % file)
            except:
                logging.error("error encountered")


push_policies = AzureStorageManagement(container_name)
push_policies.delete_blob()
push_policies.upload_policies(policies)
