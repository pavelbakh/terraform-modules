import json
import numpy as np

def lambda_handler(event, context):
    # Create a NumPy array
    array = np.array([1, 2, 3, 4, 5])

    # Perform basic operations
    array_sum = np.sum(array).item()  # Convert to native Python type
    array_mean = np.mean(array).item()  # Convert to native Python type
    array_squared = np.square(array).tolist()  # Convert to list

    # Prepare the response
    response = {
        "Original array": array.tolist(),
        "Sum of array elements": array_sum,
        "Mean of array elements": array_mean,
        "Squared array elements": array_squared
    }

    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }