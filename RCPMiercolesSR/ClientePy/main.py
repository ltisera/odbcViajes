import sys

sys.path.append('gen-py')

from ejnamespace import serviciosRapido

from thrift import thrift

from thrift.transport import TSocket
from thrift.transport import TTransport
from thrift.protocol import TBinaryProtocol