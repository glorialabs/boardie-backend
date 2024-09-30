import sys
import asyncio
import os

from aptos_sdk.account import Account
from aptos_sdk.account_address import AccountAddress
from aptos_sdk.ed25519 import PrivateKey
from aptos_sdk.async_client import RestClient, ClientConfig
from aptos_sdk.transactions import (
    EntryFunction,
    TransactionArgument,
    TransactionPayload,
)
from aptos_sdk.bcs import Serializer

from aptos_sdk.type_tag import StructTag, TypeTag

from aptos_sdk.async_client import ApiError

async def add_to_whitelist(key, board_ids, address):
    board_ids = [int(element) for element in board_ids]
    private_key = PrivateKey.from_str(key)

    my_account = Account(
            account_address=AccountAddress.from_key(private_key.public_key()),
            private_key=private_key
        )

    NODE_URL = "https://fullnode.mainnet.aptoslabs.com/v1"
    rest_client = RestClient(NODE_URL)
    payload = EntryFunction.natural(
    "0x133d00f4aef05c63944fc861f22ef732ce7a3c2652ce3b2f9ce0d226ef085f2c::boards",
    "add_to_whitelist",
    [],
    [
    TransactionArgument(board_ids,Serializer.sequence_serializer(Serializer.u64)),
    TransactionArgument(AccountAddress.from_str(address), Serializer.struct)
    ],
    )
    # transaction = await rest_client.create_bcs_transaction(my_account, TransactionPayload(payload))
    # output = await rest_client.simulate_transaction(transaction, my_account)
    # print(output)
    transaction = await rest_client.create_bcs_signed_transaction(my_account, TransactionPayload(payload))
    result = await rest_client.submit_bcs_transaction(transaction)
    print(result)
    return result

asyncio.run(add_to_whitelist(os.getenv("PRIVATE_KEY",""), sys.argv[2].split(','), sys.argv[1]))
