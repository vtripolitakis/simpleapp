import './App.css'
import { useEffect, useState } from 'react'

function App() {
  const [employees, setEmployees] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true);
        const response = await fetch('/api/employees');
        if (!response.ok) {
          throw new Error('Failed to fetch employees');
        }
        const data = await response.json();
        setEmployees(data);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };
    
    fetchData();
  }, []);

  return (
    <div className="app">
      <header className="app-header">
        <h1>Employee Management</h1>
        <p>Welcome to your React + Vite application</p>
        <div className="greeting-card">
          <h2>🎉 Congratulations!</h2>
          <p>Your React app is up and running successfully.</p>
        </div>
      </header>
      
      <main className="app-main">
        <h2>📊 Employee Directory</h2>
        
        {loading && <p>Loading employees...</p>}
        
        {error && <p className="error">Error: {error}</p>}
        
        {!loading && !error && employees.length === 0 && (
          <p>No employees found.</p>
        )}
        
        {!loading && !error && employees.length > 0 && (
          <>
            <p style={{marginBottom: '1rem', color: '#666'}}>
              Showing {employees.length} employees
            </p>
            <table className="employees-table">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Phone</th>
                  <th>Job Title</th>
                  <th>Department</th>
                  <th>Hire Date</th>
                  <th>Salary</th>
                </tr>
              </thead>
              <tbody>
                {employees.map((employee) => (
                  <tr key={employee.id}>
                    <td>{employee.id}</td>
                    <td>{`${employee.first_name} ${employee.last_name}`}</td>
                    <td>{employee.email}</td>
                    <td>{employee.phone}</td>
                    <td>{employee.job_title}</td>
                    <td>{employee.department}</td>
                    <td>{new Date(employee.hire_date).toLocaleDateString()}</td>
                    <td>${employee.salary?.toLocaleString()}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </>
        )}
      </main>
    </div>
  )
}

export default App
