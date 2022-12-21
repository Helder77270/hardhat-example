

export default function Home() {
  const [nfts, setNfts] = useState([])
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    loadNFTs()

  }, [])

 
  async function loadNFTs() {
    const provider = new ethers.providers.Web3Provider(web3.currentProvider);

    // Prompt user for account connections
    await provider.send("eth_requestAccounts", []);

    const contract = new ethers.Contract(collection.address, NFTMarketplace.abi, signer)

    const signer = provider.getSigner();
    const addr = await signer.getAddress();
    setIsLoading(false)
  }



  return (
    <div className="home">
      {
        (!isLoading && nfts.length) ?
          <Homepage
            nfts={nfts}
            highlightNfts={highlightNfts} />
          :
          <h1>No items in marketplace</h1>
      }
    </div>
  )
}