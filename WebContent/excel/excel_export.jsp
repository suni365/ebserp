<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*" %>

<%@ page import = "java.sql.*"%>

<%@page import="com.java.Dataconnect"%>

<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.util.*"%>


<%
Integer i = 1;

	Dataconnect db =new Dataconnect();
	Connection conn=Dataconnect.connectDB();
	Statement cmpst = conn.createStatement();
	ResultSet cmp = cmpst.executeQuery("select * from company order by cmp_name");
%>

<%
// create a small spreadsheet
HSSFWorkbook wb = new HSSFWorkbook();
HSSFSheet sheet = wb.createSheet("Hand Book");

HSSFRow row = sheet.createRow(0);

sheet.addMergedRegion(new CellRangeAddress(
        0, //first row (0-based)
        0, //last row  (0-based)
        0, //first column (0-based)
        5  //last column  (0-based)
));

row = sheet.createRow(0);
HSSFCell cell = row.createCell(0);
cell = row.createCell(0);

HSSFCellStyle style1 = wb.createCellStyle();
style1.setAlignment(HSSFCellStyle.ALIGN_CENTER);

HSSFFont font = wb.createFont();
font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
font.setColor(HSSFColor.SKY_BLUE.index);

style1.setFont(font);
cell.setCellStyle(style1);

cell.setCellStyle(style1);
cell.setCellValue("Hand Book");


row = sheet.createRow(1);
cell = row.createCell(0);
cell.setCellValue("SL");
cell = row.createCell(1);
cell.setCellValue("File No");
cell = row.createCell(2);
cell.setCellValue("Company Name");
cell = row.createCell(3);
cell.setCellValue("Type");
cell = row.createCell(4);
cell.setCellValue("Nature");
cell = row.createCell(5);
cell.setCellValue("Team");

while (cmp.next()) {

	row = sheet.createRow(i+1);
	cell = row.createCell(0);
	cell.setCellValue(i);
	cell = row.createCell(1);
	cell.setCellValue(Integer.parseInt(cmp.getString("file_no")));
	cell = row.createCell(2);
	cell.setCellValue(cmp.getString("cmp_name"));
	cell = row.createCell(3);
	cell.setCellValue(cmp.getString("type"));
	cell = row.createCell(4);
	cell.setCellValue(Integer.parseInt(cmp.getString("acc_type_id")));
	cell = row.createCell(5);
	cell.setCellValue(Integer.parseInt(cmp.getString("team_id")));
i++;
}

for (i = 0; i < 6; i++) {
    sheet.autoSizeColumn(i);
}

// write it as an excel attachment
ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
wb.write(outByteStream);
byte [] outArray = outByteStream.toByteArray();
response.setContentType("application/ms-excel");
response.setContentLength(outArray.length); 
response.setHeader("Expires:", "0"); // eliminates browser caching
response.setHeader("Content-Disposition", "attachment; filename=Compay Details.xls");
OutputStream outStream = response.getOutputStream();
outStream.write(outArray);
outStream.flush();

%>