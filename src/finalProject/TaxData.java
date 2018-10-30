package finalProject;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table( name = "TaxData")
public class TaxData {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id", nullable=false, unique=true)
    private int id;

    @Column(name="state", length=2, nullable=false)
    private String state;

    @Column(name="zipCode", length=11, nullable=false)
    private int zipCode;

    @Column(name="county", length=100, nullable=false)
    private String county;

    @Column(name="incomeBracket", length=11, nullable=false)
    private int incomeBracket;

    @Column(name="numReturns", length=11, nullable=false)
    private int numReturns;

    @Column(name="totalincome", length=11, nullable=false)
    private int toalIncome;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public int getIncomeBracket() {
        return incomeBracket;
    }

    public void setIncomeBracket(int incomeBracket) {
        this.incomeBracket = incomeBracket;
    }

    public int getNumReturns() {
        return numReturns;
    }

    public void setNumReturns(int numReturns) {
        this.numReturns = numReturns;
    }

    public int getToalIncome() {
        return toalIncome;
    }

    public void setToalIncome(int toalIncome) {
        this.toalIncome = toalIncome;
    }

}
