# Simple Webhook Test

## Deploymnet

The readme should provide instructions on how to spin up your solution and test it

## Cloud Implementation

The readme should contain a brief explanation of how to move this to your cloud
provider of choice, not an actual implementation just an English explanation of
going from test/POC to production

## Application Requirements Commentary

Spin up a the golang code and configure the settings to bare minimum to meet rest
of requirements.

The webhook should take the name of a text file and text to append into the text
file.

It should write the file with the contents to storage that persists through docker
compose up/down.

To fully test the webhook the sender hitting the endpoint should be from outside
the webhook container but not localhost, it should test and validate webhook
works through docker compose networking.

Webhook should also have a secure way of validating the source of the request
and not accept just any service hitting the endpoint.
