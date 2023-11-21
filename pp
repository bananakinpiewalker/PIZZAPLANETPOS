package pizzaPlanet;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.*;

@SuppressWarnings("serial")
public class PizzaPlanetPoS implements ActionListener {
	// MAIN FRAME
	public JFrame mainFrame = new JFrame("Pizza Planet POS");
	// LAYOUTS
	public GridBagLayout l = new GridBagLayout();
	public GridBagConstraints gbc = new GridBagConstraints();
	// GRAPHICS
	public ImageIcon bg = new ImageIcon(getClass().getResource("pizzaBG.png"));
	public Image b = bg.getImage();
	public ImageIcon logo = new ImageIcon(getClass().getResource("logo.png"));
	public Image logoI = logo.getImage();
	JPanel mainBG = (new JPanel(l) {
		@Override
		public void paintComponent(Graphics g) {
			g.drawImage(b, 0, 0, null);
		}
	});
	JPanel logoPanel = (new JPanel(l) {
		@Override
		public void paintComponent(Graphics g) {
			g.drawImage(b, 0, 0, null);
			g.drawImage(logoI, (mainFrame.getWidth() / 2) - logoI.getWidth(getFocusCycleRootAncestor()) / 2,
					mainFrame.getHeight() / 4, null);
		}
	});
	public JPanel copyPanel = new JPanel();
	public JLabel copy = new JLabel("© 2023 PoS Software");
	// LOGGIN DATA
	public JPanel kenny = new JPanel(l);
	public JButton login = new JButton("Kenny Loggins");
	public JTextField PIN = new JTextField(4);
	public JLabel PinLabel = new JLabel("PIN");
	public int userPIN;
	public JPanel logOutPanel = new JPanel(new GridLayout(1, 1));
	// NAV BUTTONS
	public JButton logout = new JButton("Logout");
	public JPanel navPanel = new JPanel(new GridLayout(1, 3));
	public JButton newOrder = new JButton("New Order");
	public JButton EM = new JButton("Employee Management");
	public JButton priceManagement = new JButton("Change Prices");
	public JPanel backPanel = new JPanel(new GridLayout(1, 1));
	public JButton back = new JButton("Back");
	public JPanel home = new JPanel(new GridLayout(1,1));
	public Icon homeIcon = new ImageIcon(getClass().getResource("homeLogo.png"));
	public JButton homeButton = new JButton(homeIcon);
	// ERROR HANDLING
	public JFrame errorWindow = new JFrame("Error");
	// NEW ORDER
			//pizza options
	public JPanel pizzaOps = new JPanel(new GridLayout(1, 3));
	public JPanel topOps = new JPanel(new GridLayout(2, 4));
	public ButtonGroup pizzaOpButts = new ButtonGroup();
	public JRadioButton smal = new JRadioButton("Small");
	public JRadioButton med = new JRadioButton("Medium");
	public JRadioButton larg = new JRadioButton("Large");
			//topping options
	public String[] topsString = { "Pepperoni", "Bacon", "Pepper", "Pineapple", "Sausage", "Onions", "Mushrooms",
			"Extra Cheese" };
	public ArrayList<JCheckBox> tops = new ArrayList<JCheckBox>();
			//Price calculation
	public JPanel totalPanel = new JPanel();
	public JTextField runTotal = new JTextField(10);
	public Double largPrice = 8.0;
	public Double medPrice = 6.0;
	public Double smalPrice = 5.0;
	public Double topPrice = 1.0;
	public Double totalNum = 0.0;
	public Double taxRate;
			//cart
	public JPanel calcButts = new JPanel(new GridLayout(1, 3));
	public JButton add = new JButton("Add to Order");
	public JButton soda = new JButton("Add Soda");
	public ImageIcon boxOrder = new ImageIcon(getClass().getResource("endOrder.png"));
	public JButton calc = new JButton(boxOrder);
	public ArrayList<MenuItem> orderItems = new ArrayList<MenuItem>();
	public JPanel cartPanel = new JPanel();
	public DefaultListModel items = new DefaultListModel();
	public JList cart = new JList(items);
	public JScrollPane scrollCart = new JScrollPane(cart);
	// COMPLETE ORDER
	public JPanel recPanel = new JPanel(new GridLayout (2, 1));
	public JPanel finalPanel = new JPanel(new GridLayout (1, 2));
	public JButton completeOrder = new JButton("Accept & Return");
	public JButton returnButton = new JButton("Return to Edit");
	// EM
	public JPanel EMPanel = new JPanel(new GridLayout(1, 4));
	public JButton EMAdd = new JButton("New Employee");
	public JButton EMRemove = new JButton("Delete Employee");
	public JButton EMEdit = new JButton("Edit Existing Employee");
	public JButton EMView = new JButton("View Employee Database");
	public JPanel AddPanel = new JPanel();
	public JPanel RemPanel = new JPanel();
	public JPanel EditPanel = new JPanel();
	public JPanel ViewPanel = new JPanel();
	// PM
	public JPanel PMPanel = new JPanel();
	public JLabel taxLabel = new JLabel("Tax Rate: ");
	public JTextField taxRateBox = new JTextField(20);
	public JLabel largPriceLabel = new JLabel("Large Pizza: ");
	public JTextField largPriceBox = new JTextField(20);
	public JLabel medPriceLabel = new JLabel("Medium Pizza: ");
	public JTextField smallPriceBox = new JTextField(20);
	public JLabel smalPriceLabel = new JLabel("Small Pizza: ");
	public JTextField medPriceBox = new JTextField(20);
	public JLabel topPriceLabel = new JLabel("Topping Price: ");
	public JTextField topPriceBox = new JTextField(20);
	// NAV SETS
	public JPanel[] log = { kenny, logoPanel };
	public JPanel[] nav = { navPanel, logOutPanel};
	public JPanel[] no = { pizzaOps, topOps, logOutPanel, calcButts, cartPanel , home, totalPanel};
	public JPanel[] fin = {recPanel, finalPanel, backPanel};
	public JPanel[] em = { EMPanel, logOutPanel, home};
	public JPanel[] emAdd = {AddPanel, backPanel};
	public JPanel[] emRem = {RemPanel, backPanel};
	public JPanel[] emEd = {EditPanel, backPanel};
	public JPanel[] emView = {ViewPanel, backPanel};
	public JPanel[] pm = { PMPanel, logOutPanel, home };
	public JPanel[] lastPage;
	public JPanel[] currentPage;

	public static void main(String args[]) {
		PizzaPlanetPoS m = new PizzaPlanetPoS();

		m.mainFrame.setContentPane(m.mainBG);
		m.mainFrame.setLayout(null);

		m.StandardScreenBuild();
		m.buildNewOrder();
		m.buildEM();
		m.buildPriceManagement();
		m.buildNavMenu();
		m.loginScreenBuild();

		m.mainFrame.setIconImage(m.logoI);

		m.mainFrame.setVisible(true);

		m.mainFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		m.mainFrame.setSize(1434, 800);

	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == login) {
			try {
				userPIN = Integer.parseInt(PIN.getText());
				// RUN PIN VERIFICATION
				mainFrame.setContentPane(mainBG);
				SwingUtilities.updateComponentTreeUI(mainFrame);
				mainFrame.revalidate();
				changeScene(log, no);

			} catch (Exception a) {
				System.out.println(a);
				errorWindow.setLocation(450, 200);
				errorWindow.setIconImage(logoI);
				errorWindow.setSize(400, 400);
				errorWindow.setVisible(true);
			}
		} else if (e.getSource() == homeButton) {
			changeScene(currentPage, nav);
		} else if (e.getSource() == newOrder) {
			changeScene(nav, no);

		} else if (e.getSource() == EM) {
			changeScene(nav, em);
		} else if (e.getSource() == priceManagement) {
			changeScene(nav, pm);

		} else if (e.getSource() == back) {
			changeScene(currentPage, lastPage);
		} else if (e.getSource() == logout) {
			mainFrame.setContentPane(logoPanel);
			changeScene(currentPage, log);
			userPIN = 0;
		} else if (e.getSource() == add) {
			if (pizzaOpButts.getSelection() == null) {
				errorWindow.setLocation(450, 200);
				errorWindow.setIconImage(logoI);
				errorWindow.setSize(400, 400);
				errorWindow.setVisible(true);
				for (int i = 0; i < tops.size(); i++) {
					if (tops.get(i).isSelected()) {
						tops.get(i).setSelected(false);;
					}
				}
			} else {
				try {
					addPizza(pizzaOpButts.getSelection());
					pizzaOpButts.clearSelection();
					for (int i = 0; i < tops.size(); i++) {
						if (tops.get(i).isSelected()) {
							tops.get(i).setSelected(false);;
						}
					}
				} catch (Exception r) {
					System.out.println(r);
					errorWindow.setLocation(450, 200);
					errorWindow.setIconImage(logoI);
					errorWindow.setSize(400, 400);
					errorWindow.setVisible(true);
				}
			}
		} else if (e.getSource() == soda) {
			addSoda();

		} else if (e.getSource() == calc) {

		}
	}

	public void changeScene(JPanel[] old, JPanel[] New) {
		for (int i = 0; i < old.length; i++) {
			if (old[i].isVisible()) {
				old[i].setVisible(false);
			}
		}
		for (int j = 0; j < New.length; j++) {
			New[j].setVisible(true);
		}
		lastPage = old;
		currentPage = New;
	}

	public void loginScreenBuild() {
		mainFrame.setContentPane(logoPanel);
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 1;
		gbc.gridy = 3;
		gbc.gridheight = 1;

		login.addActionListener(this);

		kenny.add(login, gbc);

		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 1;
		gbc.gridy = 2;
		gbc.gridheight = 1;
		kenny.add(PIN, gbc);

		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.gridx = 0;
		gbc.gridy = 2;
		gbc.gridheight = 1;
		kenny.add(PinLabel, gbc);

		kenny.setOpaque(false);

		mainFrame.add(kenny);
	}

	public void StandardScreenBuild() {

		logOutPanel.setBounds(10, 700, 100, 50);

		logout.addActionListener(this);

		logOutPanel.add(logout);
		logOutPanel.setOpaque(false);

		logOutPanel.setVisible(false);

		mainFrame.add(logOutPanel);

		backPanel.setBounds(70, 10, 100, 50);

		back.addActionListener(this);

		backPanel.add(back);
		backPanel.setOpaque(false);

		backPanel.setVisible(false);

		mainFrame.add(backPanel);
		home.setBounds(10, 10, 60, 60);
		
		homeButton.setBounds(10, 10, 60, 60);
		homeButton.setIcon(homeIcon);
		
		home.add(homeButton);
		
		homeButton.addActionListener(this);
		home.setOpaque(false);
		home.setVisible(false);
		
		mainFrame.add(home);
	}

	public void buildNavMenu() {
		newOrder.addActionListener(this);
		EM.addActionListener(this);
		priceManagement.addActionListener(this);

		navPanel.setBounds(160, 250, 1100, 200);
		navPanel.setOpaque(false);

		navPanel.add(newOrder);
		navPanel.add(EM);
		navPanel.add(priceManagement);

		mainFrame.add(navPanel);

		navPanel.setVisible(false);

		lastPage = nav;
	}

	public void buildNewOrder() {
		pizzaOpButts.add(smal);
		pizzaOpButts.add(med);
		pizzaOpButts.add(larg);

		pizzaOps.add(smal);
		pizzaOps.add(med);
		pizzaOps.add(larg);

		pizzaOps.setBounds(360, 75, 700, 50);//make this less off center if you have time

		pizzaOps.setOpaque(false);
		pizzaOps.setVisible(false);

		mainFrame.add(pizzaOps);

		for (int i = 0; i < topsString.length; i++) {
			tops.add(new JCheckBox(topsString[i]));
			topOps.add(tops.get(i));
		}

		topOps.setBounds(160, 150, 1100, 150);
		topOps.setVisible(false);
		topOps.setOpaque(false);

		mainFrame.add(topOps);

		calcButts.add(add);
		add.addActionListener(this);
		calcButts.add(soda);
		soda.addActionListener(this);
		calcButts.add(calc);
		calc.addActionListener(this);

		calcButts.setBounds(300, 315, 800, 70);
		calcButts.setVisible(false);

		mainFrame.add(calcButts);

		scrollCart.setBounds(0, 0, 800, 300);

		cartPanel.setBounds(300, 400, 800, 300);
		cartPanel.setVisible(false);
		cartPanel.setOpaque(false);

		cartPanel.add(scrollCart);

		mainFrame.add(cartPanel);
		
		totalPanel.add(runTotal);
		
		totalPanel.setBounds(300, 615, 800, 300);
		totalPanel.setOpaque(false);
		totalPanel.setVisible(false);
		
		mainFrame.add(totalPanel);

	}
	
	public void buildComp() {
		mainFrame.add(recPanel);
		
		
	}

	public void buildEM() {
		EMPanel.add(EMAdd);
		EMPanel.add(EMEdit);
		EMPanel.add(EMRemove);
		EMPanel.add(EMView);
		
		EMPanel.setBounds(160,250,1100,200);
		EMPanel.setVisible(false);
		EMPanel.setOpaque(false);
		
		mainFrame.add(EMPanel);
	}

	public void buildPriceManagement() {
		PMPanel.add(taxLabel);
		PMPanel.add(taxRateBox);
		PMPanel.add(smalPriceLabel);
		PMPanel.add(smallPriceBox);
		PMPanel.add(medPriceLabel);
		PMPanel.add(medPriceBox);
		PMPanel.add(largPriceLabel);
		PMPanel.add(largPriceBox);
		PMPanel.add(topPriceLabel);
		PMPanel.add(topPriceBox);
		
		PMPanel.setBounds(550, 300, 300, 1000);
		PMPanel.setVisible(false);
		PMPanel.setOpaque(false);
		
		mainFrame.add(PMPanel);
		
	}
	
	public JPanel[] getBack(JPanel[] page) {
		if (page == emAdd || page == emRem || page == emEd || page == emView) {
			return em;
		} else {
			return null;
		}
	}

	public void addSoda() {
		MenuItem soda = new MenuItem("Soda");
		totalNum = totalNum + soda.getTotal();
		items.addElement(soda);
		orderItems.add(soda);
		runTotal.setText(totalNum.toString());
	}

	public void addPizza(ButtonModel size) {
		MenuItem pizza = new MenuItem("Pizza", "", 0);
		pizza.total = getSizePrice(size);
		pizza.name = getSize(size);
		ArrayList<MenuItem> topps = new ArrayList<MenuItem>();
		for (int i = 0; i < tops.size(); i++) {
			if (tops.get(i).isSelected()) {
				topps.add(new MenuItem("Topping", topsString[i], getTopPrice(tops.get(i))));
				pizza.total = pizza.total + 1.0;
			}
		}
		items.addElement(formItem(pizza, topps));
		orderItems.add(pizza);
		totalNum = totalNum + pizza.total;
		runTotal.setText(totalNum.toString());
	}
	
	public String formItem(MenuItem p, ArrayList<MenuItem> t) {
		String top = "";
		for (int i = 0; i < t.size(); i++) {
			top = top + t.get(i).getName() + " ";
		}
		return "Pizza " + p.getName() + " [" + top + "]"; 
	}

	public double getTopPrice(JCheckBox topping) {
		return 0;
	}

	public double getSizePrice(ButtonModel size) {
		if (size == larg.getModel()) {
			return largPrice;
		} else if (size == med.getModel()) {
			return medPrice;
		} else {
			return smalPrice;
		}
	}
	
	public String getSize(ButtonModel size) {
		if (size == larg.getModel()) {
			return "Large";
		} else if (size == med.getModel()) {
			return "Medium";
		} else if (size == smal.getModel()){ 
			return "Small";
		} else {
			return "Soda";
		}
	}
	
	public Boolean isSelected(ArrayList<JCheckBox> e) {
		for (int i = 0; i < tops.size(); i++) {
			if (tops.get(i).isSelected()) {
				return true;
			}
		}
		return false;
	}
}
