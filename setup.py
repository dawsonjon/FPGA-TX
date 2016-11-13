from setuptools import setup, find_packages
setup(
    name='fpga_tx',
    description='FPGA based radio transmitter',
    author='Jon Dawson',
    author_email='chips@jondawson.org.uk',
    url='https://github.com/dawsonjon/FPGA-TX',
    version='1.0',
    scripts=['tx', 'wxtx'],
    packages=find_packages()
)
