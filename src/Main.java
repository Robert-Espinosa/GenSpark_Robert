import java.io.*;
import java.util.InputMismatchException;
import java.util.Scanner;

class Main{

    //create our parallel arrays to be used and edited from
    public static int[] ids = new int[100];
    public static String[] names = new String[100];
    public static int[] ages = new int[100];
    public static double[] grades = new double[100];
    public static int numStudents = 0;

    public static void main(String[]args){

        //create our file obj that needs to be passed into Scanner later
        File file = new File("src/students.txt");

        //get ready to parse information
        int localId;
        String localName;
        int localAge;
        double grade;

        try {
            // Create a Scanner object to read from the file
            Scanner scanner = new Scanner(file);

            while (scanner.hasNextLine()) {
                //while loop to parse data specifically how instructed
                localId = scanner.nextInt();
                localName = scanner.next();
                localAge = scanner.nextInt();
                grade = scanner.nextDouble();

                addStudent(localId, localName, localAge, grade);

                }

            // Close the scanner when you are done
            scanner.close();

        } catch (FileNotFoundException e) {
            // file is not found
            System.out.println("The file not found.");
        }

        // create another scanner to take input from command line
        Scanner scanner = new Scanner(System.in);

        printMenu();

        String input;
        while (!(input = scanner.next()).equals("-1")) {

            int result = 0;
            try {
                result = Integer.parseInt(input);
            } catch (NumberFormatException e) {
                System.out.println("Invalid input Please enter a number from 1-5 or -1 to quit" + input);
            }

            //add student
            if(result == 1){
                try {
                    System.out.print("Enter student ID: ");
                    int id = scanner.nextInt();
                    System.out.print("enter the Student name: ");
                    String name = scanner.next();
                    System.out.print("enter the sutdnet age: ");
                    int age = scanner.nextInt();
                    System.out.print("enter the student grade: ");
                    double gradeInput = scanner.nextDouble();
                    addStudent(id, name, age, gradeInput);
                    System.out.print("success!");
                } catch(InputMismatchException e){
                    System.out.print("please enter an valid Intger, String, integer, and double to add student\n");
                }

            }//update student
            else if(result == 2){
                try {
                    System.out.print("Enter the ID of student you would like to update ");
                    int id = scanner.nextInt();
                    System.out.print("Enter the new grade ");
                    double localGrade = scanner.nextDouble();
                    updateStudent(id, localGrade);
                }catch(InputMismatchException e){

                    System.out.print("Please enter a valid Student ID and Valid grade\n");
                }

            }//search by ID
            else if(result == 3){
                System.out.print("Enter student ID: ");
                try {
                    String id = scanner.next();
                    printStudent(indexOfStudent(Integer.parseInt(id)));
                } catch (NumberFormatException e) {
                    System.out.println("Invalid input Please enter a valid interger for ID");
                }
            }//view all students
            else if(result == 4){
                viewStudents();
            }//delete all student
            else if(result == 5){
                try {
                    System.out.print("Please Enter the ID of student you want to delete: ");
                    int id = scanner.nextInt();
                    deleteStudent(id);
                }catch(InputMismatchException e){
                    System.out.print("Please enter a valid Student ID and Valid grade\n");
                }
            }else{
                System.out.print("please enter a number from 1-5\n");
            }
            printMenu();
        }
    }

    public static void addStudent(int id, String Name, int age, double grade){
        for(int i = 0; i < ids.length; i++){
            if(ids[i] == 0){
                ids[i] = id;
                names[i] = Name;
                ages[i] = age;
                grades[i] = grade;
                numStudents++;
                printToFile();
                return;
            }
        }
    }

    //made a method to print to so everytime a student is added, updated, or deleted it rewrites the orginal file.
    public static void printToFile(){
        try (PrintWriter writer = new PrintWriter(new File("src/students.txt"))) {

            for(int i =0; i<numStudents;i++){
                writer.print(ids[i]+" "+names[i]+" "+ages[i]+" "+grades[i]+"\n");
            }

        } catch (FileNotFoundException e) {
            System.err.println("Error file not written");
        }
    }

    /*
        Created static method to print out options on student book.
     */
    public static void printMenu(){

        System.out.print("Welcome to the Student Gradebook Enter 1-5 with options below or -1 to quit\n");
        System.out.println("1. add Student ");
        System.out.println("2. update Student ");
        System.out.println("3. Search student by ID ");
        System.out.println("4. view all students ");
        System.out.println("5. delete a student ");
    }


    public static void viewStudents(){
        for(int i =0; i < ids.length; i++){
            // loop thru evetyhing where the ID is not 0
            if(ids[i] != 0) {
                System.out.println("ID:" + ids[i] + " Name:" + names[i] + " Age:" + ages[i] + " Grade:" + grades[i]);
            }
        }

    }

    public static int indexOfStudent(int id){
        //made an index of method for ease of finding the correct index.
        //it can be used in other methods to find correct students.
        for(int i = 0; i < ids.length;i++){
            if(id == ids[i] && id !=0){
                return i;
            }
        }

        return -1;
    }
    public static void printStudent(int index){
        //Takes in the index and starts printing information from parallel arrays.
        if(index>=0 && index < 100) {
            System.out.println("ID:" + ids[index] + " Name:" + names[index] + " Age:" + ages[index] + " Grade:" + grades[index]);
        }else{
            System.out.println("No ID found\n");
        }

    }

    //need to fix indexing in the array
    public static void deleteStudent(int id){

        int index = indexOfStudent(id);
        if(index != -1){
            names[index] = "";
            ids[index] = 0;
            ages[index] = 0;
            grades[index] = 0;
            numStudents--;
            printToFile();
            return;
        }else{
            System.out.print("Student ID NOT FOUND!!");
        }
    }

    public static void updateStudent(int id,double grade){
        //get the index of student then simply change grade
        int index = indexOfStudent(id);
        if(index != -1) {
            grades[index] = grade;
            printToFile();
        }
        else{
            System.out.println("ERROR: Need to enter a valid ID of a Student");
        }
    }

}
