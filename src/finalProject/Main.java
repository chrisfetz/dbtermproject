package finalProject;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class Main {

    public static void main(String[] args) {

        // get restaurant with id=77
        Restaurant restaurant = getRestaurant(77);
        System.out.println(restaurant.getName());
    }

    /**
     * Returns a restaurant
     * @param id restaurant id
     * @return finalProject.Restaurant object
     */
    private static Restaurant getRestaurant(int id) {
        SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        Session session = sessionFactory.openSession();
        Restaurant restaurant = session.load(Restaurant.class,id);
        return restaurant;
    }


}
