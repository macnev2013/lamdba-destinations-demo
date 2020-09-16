aws iam create-role \
	--endpoint-url http://localhost:4566 \
	--role-name lambda-ex \
	--assume-role-policy-document file://trust-policy.json

aws iam attach-role-policy \
	--endpoint-url http://localhost:4566 \
	--role-name lambda-ex \
	--policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole

zip function.zip index.js

aws lambda create-function \
	--endpoint-url http://localhost:4566 \
	--function-name my-function \
	--zip-file fileb://function.zip \
	--handler index.handler \
	--runtime nodejs12.x \
	--role arn:aws:iam::123456789012:role/lambda-ex

aws lambda put-function-event-invoke-config \
	--endpoint-url http://localhost:4566 \
	--function-name my-function \
	--cli-input-json file://lambda-dest.json

aws lambda update-function-event-invoke-config \
	--endpoint-url http://localhost:4566 \
	--function-name my-function \
	--cli-input-json file://lambda-dest.json