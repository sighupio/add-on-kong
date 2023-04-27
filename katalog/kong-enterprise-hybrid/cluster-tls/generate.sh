#!/bin/bash
# Copyright (c) 2022 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


# Example script to generate certs

openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) \
  -keyout cluster.key -out cluster.crt \
  -days 1095 -subj "/CN=kong_clustering"
