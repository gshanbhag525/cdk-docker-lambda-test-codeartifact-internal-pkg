from aws_cdk import (
    Stack,
    aws_lambda as aws_lambda,
)
from constructs import Construct

class CdkAppStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        lambda_function = aws_lambda.Function(self, "ContainerImageDemo",
            code=aws_lambda.Code.from_asset_image(directory="./", exclude=["cdk.out"]),
            handler=aws_lambda.Handler.FROM_IMAGE,
            runtime=aws_lambda.Runtime.FROM_IMAGE,
            function_name="artifact_lambda"
        )
