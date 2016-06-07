package controlador;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class UploadServlet
 */
public class UploadServlet2 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DATA_DIRECTORY = "data";
    private static final int MAX_MEMORY_SIZE = 1024 * 1024 * 2;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	System.out.println(" **************** Inicio de Carga **********************");
    	//System.out.println(" request "+request.getMethod());
    	
    	//HttpServletRequest r2= new HttpServletRequest():
        // Check that we have a file upload request
    	
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        
        //System.out.println(" isMultipart : " +isMultipart);
        
        
        
        if (!isMultipart) {
            return;
        }

        
        // Create a factory for disk-based file items
        DiskFileItemFactory factory = new DiskFileItemFactory();

        // Sets the size threshold beyond which files are written directly to
        // disk.
        factory.setSizeThreshold(MAX_MEMORY_SIZE);

        // Sets the directory used to temporarily store files that are larger
        // than the configured size threshold. We use temporary directory for
        // java
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        // constructs the folder where uploaded file will be stored        
        
        //String uploadFolder = getServletContext().getRealPath("")
        //        + File.separator + DATA_DIRECTORY;
        
        String uploadFolder = "C:/data4fimi/";

        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);

        // Set overall request size constraint
        upload.setSizeMax(MAX_REQUEST_SIZE);

        try {
            // Parse the request
            List items = upload.parseRequest(request);
            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();

                if (!item.isFormField()) {
                    String fileName = new File(item.getName()).getName();                                    
         		    java.text.SimpleDateFormat formato= new java.text.SimpleDateFormat("yymmddhh");
         		    
         		    String fileNameBD =formato.format(new java.util.Date()) + fileName;
         		    
         		    
         		    String filePath = uploadFolder + File.separator + fileNameBD ;
                    File uploadedFile = new File(filePath);
                    //System.out.println(filePath);
                    // saves the file to upload directory
                    item.write(uploadedFile);
                }
            }
            System.out.println(" ****************Carga Realizada**********************");
            
            // displays done.jsp page after upload finished
            //getServletContext().getRequestDispatcher("/done.jsp").forward(request, response);
            //getServletContext().getRequestDispatcher("/Upload2.jsp").forward(request, response);

        } catch (FileUploadException ex) {
            throw new ServletException(ex);
        } catch (Exception ex) {
            throw new ServletException(ex);
        }

    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//request.
    	//System.out.println(" request "+request);
    	doPost(request,response);
        //request.getMethod()
    	
    	//System.out.println(" **************** doGet **********************");
            }


}