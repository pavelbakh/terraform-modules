# Example of using modules tf-aws-lambda and tf-aws-lambda-layer



## To create a Lambda layer for numpy using pip and requirements.txt, follow these steps:

1. **Create a directory for the layer:**

    ```sh
    mkdir python
    ```

2. **Install the dependencies into the python directory:**

    ```sh
    pip install -r requirements.txt -t python/
    ```

3. **Zip the contents of the python directory:**

    ```sh
    zip -r numpy-layer.zip python
    ```

4. **Upload the zip file to S3:**

    ```sh
    aws s3 cp numpy-layer.zip s3://your-bucket-name/path/to/numpy-layer.zip
    ```
Replace `your-bucket-name` and `path/to/` with your actual S3 bucket name and desired path.

## To upload a zipped `lambda_handler.py` to S3 using the AWS CLI, follow these steps:

1. **Zip the `lambda_handler.py` file**:
   ```sh
   zip lambda_handler.zip lambda_handler.py
   ```

2. **Upload the zip file to S3**:
   ```sh
   aws s3 cp lambda_handler.zip s3://your-bucket-name/path/to/lambda_handler.zip
   ```

To upload a zipped `lambda_handler.py` to S3 using the AWS CLI, follow these steps:

1. **Zip the `lambda_handler.py` file**:
   ```sh
   zip lambda_handler.zip lambda_handler.py
   ```

2. **Upload the zip file to S3**:
   ```sh
   aws s3 cp lambda_handler.zip s3://your-bucket-name/path/to/lambda_handler.zip
   ```

Replace `your-bucket-name` and `path/to/` with your actual S3 bucket name and desired path.