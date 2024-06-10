#!/usr/bin/python3.8
################################################################################
#
# Copyright (c) 2022 Qumulo, Inc. All rights reserved.
#
# NOTICE: All information and intellectual property contained herein is the
# confidential property of Qumulo, Inc. Reproduction or dissemination of the
# information or intellectual property contained herein is strictly forbidden,
# unless separate prior written permission has been obtained from Qumulo, Inc.
#
# Filename: anq_create_cluster.py
# Name:     Create ANQ CLuster Python script
# Date:     June 4th, 2024
# Author:   kmac@qumulo.com
#
# Modify according to your specific environment
#
################################################################################


import subprocess
import json
import argparse

def submit_cluster_creation(subscription, fs_name, user_email, location, availability_zone, rg_name, cluster_subnet_id):
    body = {
        'properties': {
            'marketplaceDetails': {
                'planId': 'azure-native-qumulo-hot-cold-iops',
                'offerId': 'qumulo-saas-mpp'
            },
            'userDetails': {'email': user_email},
            'delegatedSubnetId': cluster_subnet_id,
            'storageSku': 'Hot',
            'adminPassword': 'Password123',
            'availabilityZone': availability_zone
        },
        'location': location,
        'tags': {
        }
    }

    body_str = json.dumps(body, indent=4)
    print("Submitting cluster create for:\n")
    print(body_str)
    print("\n")

    try:
        result = subprocess.run(
            [
                'az',
                'rest',
                '--verbose',
                '--method',
                'PUT',
                '--url',
                f'https://centraluseuap.management.azure.com/subscriptions/{subscription}/resourceGroups/{rg_name}/providers/Qumulo.Storage/fileSystems/{fs_name}?api-version=2024-02-01-preview',
                '--resource',
                'https://management.azure.com/',
                '--body',
                body_str,
            ],
            capture_output=True,
            text=True,
            check=True,
        )

        print("Command executed successfully.")
        print("Standard Output:")
        print(result.stdout)
        print("Standard Error:")
        print(result.stderr)

        headers = result.stdout.splitlines()
        azure_async_operation_header = None
        all_headers = []

        for header in headers:
            all_headers.append(header)
            print("All Headers:")
            for header in all_headers:
                print(header)

    except subprocess.CalledProcessError as e:
        print("Error:", e)
        print("Standard Output:")
        print(e.stdout)
        print("Standard Error:")
        print(e.stderr)

def main():
    usage = "python3.8 anq_create_cluster.py --subscription SUB --fs-name FS --user_email EMAIL --location LOC --availability-zone AZ --qumulo-num-nodes NODES --rg-name RG --cluster-subnet-id SUBNET_ID"
    parser = argparse.ArgumentParser(description='Submit cluster creation to Azure.', usage=usage)
    parser.add_argument('--subscription', type=str, help='Azure subscription ID', required=True)
    parser.add_argument('--fs-name', type=str, help='File system name', required=True)
    parser.add_argument('--user_email', type=str, help='User email', required=True)
    parser.add_argument('--location', type=str, help='Location', required=True)
    parser.add_argument('--availability-zone', type=str, help='Availability zone', required=True)
    parser.add_argument('--rg-name', type=str, help='Resource group name', required=True)
    parser.add_argument('--cluster-subnet-id', type=str, help='Cluster subnet ID', required=True)

    args = parser.parse_args()

    submit_cluster_creation(
        args.subscription, args.fs_name, args.user_email, args.location, args.availability_zone, args.rg_name, args.cluster_subnet_id
    )

if __name__ == "__main__":
    main()
