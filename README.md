# Ortelius v11 Domain Microservice
RestAPI for the Domain Object
![Release](https://img.shields.io/github/v/release/ortelius/domain?sort=semver)
![license](https://img.shields.io/github/license/ortelius/domain)

![Build](https://img.shields.io/github/actions/workflow/status/ortelius/domain/build-push-chart.yml)
[![MegaLinter](https://github.com/ortelius/domain/workflows/MegaLinter/badge.svg?branch=main)](https://github.com/ortelius/domain/actions?query=workflow%3AMegaLinter+branch%3Amain)
![CodeQL](https://github.com/ortelius/domain/workflows/CodeQL/badge.svg)
[![OpenSSF-Scorecard](https://api.securityscorecards.dev/projects/github.com/ortelius/domain/badge)](https://api.securityscorecards.dev/projects/github.com/ortelius/domain)

![Discord](https://img.shields.io/discord/722468819091849316)

## Version: 11.0.0

### Terms of service
<http://swagger.io/terms/>

**Contact information:**
Ortelius Google Group
ortelius-dev@googlegroups.com

**License:** [Apache 2.0](http://www.apache.org/licenses/LICENSE-2.0.html)

---
### /msapi/domain

#### GET
##### Summary

Get a List of Domains

##### Description

Get a list of domains for the user.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | OK |

#### POST
##### Summary

Create a Domain

##### Description

Create a new Domain and persist it

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | OK |

### /msapi/domain/:key

#### GET
##### Summary

Get a Domain

##### Description

Get a domain based on the _key or name.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | OK |
