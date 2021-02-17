docker run -v support/cicd/requirements.txt:/tmp/requirements.txt \
           -v support/cicd/upload_to_blob_using_sas.py:/tmp/upload_to_blob_using_sas.py \
           -v policies/compliance/custom:/tmp/custom \
           -e SAS_TOKEN="?sv=2019-02-xxx" 
           -it python:3.6 bash

pip install -r /tmp/requirements.txt

python /tmp/upload_blob_using_sas.py /tmp/custom demostorage c7n-aci-policies