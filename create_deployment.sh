#!/bin/bash
## You can use this from cloudshell also
aws deploy create-deployment --application-name "CodeDeployApp-test-deploy" \
--deployment-group-name "CodeDeployDeploymentGroup-test-deploy" \
--github-location repository="lroquec/aws-codepipeline",commitId="6b77dbaccc6e7423efe9ca10cb5026115cc40dff"