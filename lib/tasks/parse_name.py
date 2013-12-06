#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
sys.path.append('/Users/poc/Dropbox/Python/sony_cgi_command/libs')
sys.path.append('/Users/poc/Dropbox/Python/sony_cgi_command/common_libs')
#standard lib
import argparse
import re
import os
import time
import string
import difflib
import copy
from pprint import pprint
from timeit import default_timer as timer
#3rd part lib
import xlrd 
from xlutils.copy import copy
import xlwt
import httplib2
#load custom library (remember to set PYTHONPATH in your .bashrc)
from color_print import *
from debug_tool import *

from Excel import XlsOperation as xls_oper
from Excel.XlsOperation import ReadWrite as rw_xls
from Excel.XlsOperation import XlsTools as xls_tools
from Converter import ParseXLS as parse_xls


#global variables
p_args=[]
cgi_items=[]
export_file_name={"error_log":"cgi_get_set_error_log.txt",
                  "warn_log":"cgi_get_set_warn_log.txt",                 
                  "excel_report":"cgi_get_set_report.xls"}
_DEBUG=False

class SampleXls(object, xls_tools):
    """docstring for SampleXls"""
    def __init__(self, arg):
        super(SampleXls, self).__init__()
        self.arg = arg
        self.wb = xlrd.open_workbook(arg.xls)
        self.sht = self.wb.sheet_by_index(0)
        self.book_array = []
        self.save_file_name = os.path.splitext(arg.xls)[0]+'.txt'
    def run(self):
        print('start...')
        
        n_rows, n_cols = self.sht.nrows, self.sht.ncols

        for i in range(1, n_rows):
            new_book = []
            for j in range(0, n_cols):
                new_book.append( str(self.get_cell(self.sht, i, j)) )

            self.book_array.append(new_book)

        f = open(self.save_file_name, 'w')
        for book in self.book_array:
            f.write("|||".join(book) +'\n')
        f.close()


def main():

    global p_args, sony_grps

    start_time = timer()

    p = argparse.ArgumentParser(
        description='For generating URL Command Document ',)
    p_add= p.add_argument
    p_add('-f', action="store", dest="xls", help="Excel file name")

    p_args = p.parse_args()
    sample = SampleXls(p_args)
    sample.run()


    print("Elapsed time : %f " % (timer()-start_time))

    pass

if __name__ == '__main__':
    p_yel("dodo")
    main()