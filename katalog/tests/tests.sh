#!/usr/bin/env bats
# shellcheck disable=SC2154,SC2034,SC2086,SC2103
# Copyright (c) 2022 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


load helper

set -o pipefail

@test "Applying Monitoring CRDs" {
  info
  kubectl create ns monitoring
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.14.2/katalog/prometheus-operator/crd-servicemonitor.yml
  kubectl apply -f https://raw.githubusercontent.com/sighupio/fury-kubernetes-monitoring/v1.14.2/katalog/prometheus-operator/crd-rule.yml
}

@test "Deploy Kong Ingress Controller" {
  info
  deploy() {
    kaction katalog/kong/kong-dbless apply
  }
  run deploy
  [[ "$status" -eq 0 ]]
}

@test "Wait Kong Ingress Controller" {
  info
  test(){
    status=$(kubectl get pods -n kong -l app=ingress-kong -o jsonpath="{.items[*].status.phase}")
    for state in $status; do
      if [ "${state}" != "Running" ]; then return 1; fi
    done
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}


@test "Deploy Petstore example app" {
  info
  deploy() {
    kaction examples/petstore apply
  }
  run deploy
  [[ "$status" -eq 0 ]]
}

@test "Wait for Petstore app" {
  info
  test(){
    status=$(kubectl get pods -n petstore -l app=petstore -o jsonpath="{.items[*].status.phase}")
    for state in $status; do
      if [ "${state}" != "Running" ]; then return 1; fi
    done
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Check that Petstore example app is working via GET /pet/1 route" {
  info
  test() {
    http_code=$(curl "http://${INSTANCE_IP}/pet/1" -s -o /dev/null -w "%{http_code}")
    if [ "${http_code}" -ne "200" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Check that Petstore example app denying POST on /pet/1 route" {
  info
  test() {
    http_code=$(echo '{"stuff": 1}' | curl -d @- "http://${INSTANCE_IP}/pet/1" --header "Content-Type:application/json" -s -o /dev/null -w "%{http_code}")
    if [ "${http_code}" -ne "404" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Testing Petstore example app rate limiting /pet/1 route" {
  info
  test() {
    for i in {1..5}; do http_code=$(curl "http://${INSTANCE_IP}/pet/1" -s -o /dev/null -w "%{http_code}"); done
    if [ "${http_code}" -ne "429" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Testing Petstore example app basic auth /user route" {
  info
  test() {
    http_code=$(echo '{"id": 1,"username": "user","firstName": "user","lastName": "user","email": "user@user.tld","password": "user","phone": "1234","userStatus": 0 }' | curl -d @- http://${INSTANCE_IP}/user  -u user:123456 --header "Content-Type:application/json" -s -o /dev/null -w "%{http_code}")
    if [ "${http_code}" -ne "200" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Check that Petstore example app is working via GET /store/inventory route and host awesome-kong.io" {
  info
  test() {
    http_code=$(curl "http://${INSTANCE_IP}/store/inventory" -H 'host: awesome-kong.io' -s -o /dev/null -w "%{http_code}")
    if [ "${http_code}" -ne "200" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}
