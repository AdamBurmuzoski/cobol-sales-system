# COBOL Sales System

## Overview

The **COBOL Sales System** is a program designed to generate a Year-to-Date (YTD) sales report based on customer sales data. It processes a fixed-format input file containing sales records, calculates total sales, and produces a formatted output report. The report includes individual customer sales details and overall totals, presented in a clean and professional format.

This project demonstrates proficiency in COBOL programming and highlights its use in processing and generating meaningful business reports.

---

## Key Features

- **File Processing**  
  Reads input from a customer sales file and writes to a structured sales report file.

- **Data Aggregation**  
  Computes total current and previous YTD sales for all customers.

- **Formatted Output**  
  Generates a clean, professional report with headings, customer details, and totals.

- **Dynamic Reporting**  
  Automatically updates the current date and time in the report header.

- **COBOL Best Practices**  
  Implements modular design with distinct routines for initialization, data processing, and cleanup, ensuring readability and maintainability.

---

## Technical Details

- **Language**: COBOL  
- **Input File**: Fixed-length records containing:  
  - Customer names  
  - Branch numbers  
  - Sales representative numbers  
  - YTD sales figures  
- **Output File**: Formatted text file with detailed sales data and summaries.  
- **Dependencies**:  
  - Requires a COBOL compiler like **GnuCOBOL** or an equivalent development environment for execution.

---

## How to Run

1. Ensure you have a COBOL compiler installed, such as **GnuCOBOL**.
2. Place the input file (`customer_sales.dat`) in the appropriate directory as expected by the program.
3. Compile the program using the COBOL compiler:  
     cobc -x -o cobol_sales_system cobol_sales_system.cbl
4. Execute the program:
     ./cobol_sales_system
5. Check the generated sales report file for the results (sales_report.txt).

---

## License

© Adam Burmuzoski. All rights reserved.

