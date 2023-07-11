#!/usr/bin/env python3
""" 12-log_stats """

from pymongo import MongoClient

if __name__ == "__main__":
    client = MongoClient('mongodb://127.0.0.1:27017')
    logs_collection = client.logs.nginx

    total_logs = logs_collection.count_documents({})
    print(f"{total_logs} logs")

    method_count = logs_collection.count_documents({"method": "GET"})
    print(f"Methods:\n\tmethod GET: {method_count}\n\tmethod POST: 0\n\tmethod PUT: 0\n\tmethod PATCH: 0\n\tmethod DELETE: 0")

    status_check_count = logs_collection.count_documents({"method": "GET", "path": "/status"})
    print(f"{status_check_count} status check")

    print("IPs:")
    top_ips = logs_collection.aggregate([
        {"$group": {"_id": "$ip", "count": {"$sum": 1}}},
        {"$sort": {"count": -1}},
        {"$limit": 10}
    ])

    for ip in top_ips:
        print(f"\t{ip['_id']}: {ip['count']}")

