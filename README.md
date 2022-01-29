# Simple Webhook Test

The following application contains two parts: a simple webhook application and a client to test/verify functionality.

To spin up the the webhook application and run the test client you must have [docker-compose](https://docs.docker.com/compose/install/) installed.

Simply run `docker-compose up`.

If the test client exits with a non-zero exit code then the test suite failed, otherwise all written tests passed.

Please note that if you run the application detached (with -d) then you will not get the feedback directly in your command prompt.

## Cloud Implementation

When moving this to a cloud environment I would go with a serverless option, since we only need to spin this up for testing purposes. My cloud provider of choice is AWS, so we could deploy testing of this application within Fargate on Elastic Container Service (ECS). Since we have already created a docker-compose configuration the easiest way to transfer this would be to use the ecs-cli to run `compose service up`. This command looks for docker-compose files and runs them on an existing cluster, therefore the only extra effort here would be to create the cluster and ensure your aws-cli is setup properly. This could all be configured within a Jenkins or other CI/CD pipeline.

While this moves the current application setup to the cloud I would reccommend improvements, such as moving the authentication keys into AWS Key Management Service (KMS). There are also much better methods for API testing, most notably the CodeBuild service, which would enable us to verify tests by creating a build pipeline.
